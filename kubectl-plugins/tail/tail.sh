#!/bin/bash

set -eou pipefail

[[ -n "${DEBUG:-}" ]] && set -x

# set of colors for output. We rotate through them and re-use for each log tailer.
COLORS=("[31m" "[32m" "[33m" "[34m" "[35m" "[36m") # TODO: MORE COLORS!
RESET_COLOR="[0m"
ESC=$(printf '\033')

main() {
  SELECTOR=""
  KUBECTL_ARGS=()

  set_kubectl_global_args

  if [[ -z "$KUBECTL_PLUGINS_LOCAL_FLAG_SELECTOR" ]]; then
    echo "Missing '-l' flag. Run with '-h' for usage."
    exit 1
  fi
  SELECTOR="$KUBECTL_PLUGINS_LOCAL_FLAG_SELECTOR"

  # ensure we cleanup the `kubectl logs -f` procs that will be fork'd (&)
  trap shutdown SIGINT SIGTERM

  # for each container in each matching pod, start a `kubectl logs -f ... &`
  local cnt=0
  for i in $(list_containers); do
    local pod container
    # split "pod:container" string into parts:
    IFS=: read -r pod container <<<"$i"

    # pick a color from the $COLORS array
    local color_idx=$(( cnt % ${#COLORS[@]} ))
    local color="${COLORS[$color_idx]}"

    # created a fixed length prefix containing the container name for each line of log output
    local line_prefix=''
    line_prefix=$(printf "|%-27s | " "$pod::$container")

    (kubectl "${KUBECTL_ARGS[@]}" logs --tail=10 --timestamps=false --follow -c "$container" "$pod" 2>&1 \
       | sed "s/^/${ESC}${color}${line_prefix}/; s/$/${ESC}${RESET_COLOR}/") &

    cnt=$((cnt + 1))
  done

  # wait for all the forked kubectl procs
  wait
}

# set_kubectl_global_args iterates through all env vars matching "KUBECTL_PLUGINS_GLOBAL_FLAG_<NAME>"
# and converts them into the form suitable for `kubectl`, eg: KUBECTL_PLUGINS_GLOBAL_FLAG_CONTEXT => --context
# and adds them to the $KUBECTL_ARGS array. This allows us to acquire and re-use all of the global
# kubectl options that were passed into the plugin for our own calls to `kubectl`.
#
# eg:
#   set_kubectl_global_args
#   kubectl "${KUBECTL_ARGS[@]}" ...
#
set_kubectl_global_args() {
  local flag env_var_name

  for flag in \
    as \
    certificate-authority \
    client-certificate \
    client-key \
    cluster \
    context \
    insecure-skip-tls-verify \
    kubeconfig \
    password \
    server \
    token \
    user \
    username; do
    env_var_name=$(flag_to_env_var "$flag")

    # if the environment var is set add it to the KUBECTL_ARGS array
    if [[ -n "${!env_var_name:-}" ]]; then
      KUBECTL_ARGS+=("--${flag}=${!env_var_name}")
    fi
  done

  # namespace is handled slightly differently. The KUBECTL_PLUGINS_CURRENT_NAMESPACE
  # flag is set by kubectl after all processing of --namespace/--context/etc has occurred.
  if [[ ! -z "$KUBECTL_PLUGINS_CURRENT_NAMESPACE" ]]; then
    KUBECTL_ARGS+=("--namespace=${KUBECTL_PLUGINS_CURRENT_NAMESPACE}")
  fi
}

# flag_to_env_var converts a kubernetes global flag (`kubectl options`) name into
# the environment variable form of the name according to the kubectl-plugins API:
# https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/#accessing-runtime-attributes
#
# ex:
#    flag_to_env_var "certificate-authority"
#    -> KUBECTL_PLUGINS_GLOBAL_FLAG_CERTIFICATE_AUTHORITY
#
flag_to_env_var() {
  local flag="$1"

  flag="${flag//-/_}" # convert any '-' to '_'
  flag="$(awk '{ print toupper($0) }' <<<"$flag")" # uppercase
  flag="KUBECTL_PLUGINS_GLOBAL_FLAG_${flag}" # add prefix
  printf "%s" "$flag"
}

shutdown(){
  echo "Stopping"
  trap - SIGINT SIGTERM  # reset handler to avoid loops
  kill -TERM 0
}

# this func uses a go-template to print a newline terminated list of "pod:container"
# for example, a pod named 'foo' with containers 'nginx, app, proxy' would render as:
#  foo:nginx
#  foo:app
#  foo:proxy
list_containers() {
  # shellcheck disable=SC2016
  kubectl "${KUBECTL_ARGS[@]}" get pod "-l$SELECTOR" \
    -o go-template='{{ range .items }}{{$pod := .metadata.name}}{{ range .spec.containers }}{{$pod}}{{":"}}{{.name}}{{"\n"}}{{ end }}{{ end }}'
}

main "$@"
