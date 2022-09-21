ARG ALPINE_VERSION

FROM mheers/alpine-tools:${ALPINE_VERSION}

USER root
ENV PATH "$PATH:/root/.arkade/bin/"

RUN apk add \
    fzf \
    zsh

## Install arkade
RUN curl -sLS https://get.arkade.dev | sh
ENV PATH "$PATH:/root/.arkade/bin/"

# RUN ark get --quiet argocd `# gitops`
# RUN ark get --quiet argocd-autopilot `# opinionated argocd helper`
# RUN ark get --quiet dagger `# devkit for ci/cd pipelines`
# RUN ark get --quiet docker-compose
# RUN ark get --quiet helm `# needed? yaml bundler - then also 'nova' would be useful`
# RUN ark get --quiet hostctl `# tool for managing /etc/hosts`
RUN ark get --quiet jq `# json parser / manipulator`
RUN ark get --quiet k3d `# kubernetes cluster manager (k3s on docker)`
RUN ark get --quiet k9s `# kubernetes cluster cli admin tui`
RUN ark get --quiet krew `# package manager for kubectl plugins`
RUN ark get --quiet kubectl `# kubernetes cli`
RUN ark get --quiet kubectx `# kubernetes context manager`
RUN ark get --quiet kubens `# kubernetes namespace manager`
# RUN ark get --quiet kubescape `# hardening kubernetes (NSA/CISA)`
# RUN ark get --quiet kubeseal `# needed? seal kubernetes secrets`
# RUN ark get --quiet linkerd2 `# needed? linkerd cli`
# RUN ark get --quiet polaris `# scan and check k8s pods`
# RUN ark get --quiet promtool `# prometheus rule tester`
# RUN ark get --quiet terraform `# needed? infrastructure as code`
# RUN ark get --quiet vault `# needed? vault cli`
RUN ark get --quiet yq `# yaml parser / manipulator`

## Install krew plugins
RUN krew install krew
ENV PATH "$PATH:/root/.krew/bin/"
# RUN kubectl krew install access-matrix `# show an RBAC access matrix for server resources`
# RUN kubectl krew install azad-proxy `# Generate and handle authentication for Azure AD`
# RUN kubectl krew install cert-manager `# Manage cert-manager resources inside your cluster`
# RUN kubectl krew install cilium `# Easily interact with Cilium agents`
# RUN kubectl krew install config-cleanup `# Automatically clean up your kubeconfig`
# RUN kubectl krew install creyaml `# Generate custom resource YAML manifest`
# RUN kubectl krew install cyclonus `# NetworkPolicy analysis tool suite`
# RUN kubectl krew install datree `# Scan your cluster resources for misconfigurations`
# RUN kubectl krew install dds `# Detect if workloads are mounting the docker socket`
# RUN kubectl krew install df-pv `# Show disk usage (like unix df) for persistent volumes`
# RUN kubectl krew install doctor `# Scans your cluster and reports anomalies`
# RUN kubectl krew install evict-pod `# Evicts the given pod`
# RUN kubectl krew install example	`# Prints out example manifest YAMLs`
RUN kubectl krew install exec-as `# Like kubectl exec, but offers a 'user' flag to exec as root or any other user`
# RUN kubectl krew install exec-cronjob `# Run a CronJob immediately as Job`
# RUN kubectl krew install fields `# Grep resources hierarchy by field name`
# RUN kubectl krew install flame `# Generate CPU flame graphs from pods`
RUN kubectl krew install images `# Show container images used in the cluster`
# RUN kubectl krew install janitor `# Lists objects in a problematic state`
# RUN kubectl krew install ktop `# A top tool to display workload metrics`
# RUN kubectl krew install lineage `# Display all dependent resources or resource dependencies`
# RUN kubectl krew install neat `# Remove clutter from Kubernetes manifests to make them more readable`
# RUN kubectl krew install node-shell `# Spawn a root shell on a node via kubectl`
# RUN kubectl krew install np-viewer `# Network Policies rules viewer`
# RUN kubectl krew install outdated `# Finds outdated container images running in a cluster`
# RUN kubectl krew install popeye `# scan and check k8s pods`
# RUN kubectl krew install preflight `# Executes application preflight tests in a cluster`
# RUN kubectl krew install pv-migrate `# Migrate data across persistent volumes`
# RUN kubectl krew install rbac-tool `# Plugin to analyze RBAC permissions and generate policies`
# RUN kubectl krew install relay `# Drop-in "port-forward" replacement with UDP and hostname resolution`
# RUN kubectl krew install resource-capacity `# Provides an overview of resource requests, limits, and utilization`
# RUN kubectl krew install rm-standalone-pods `# Remove all pods without owner references`
# RUN kubectl krew install score `# Kubernetes static code analysis`
# RUN kubectl krew install slice `# Split a multi-YAML file into individual files`
# RUN kubectl krew install sniff `# Start a remote packet capture on pods using tcpdump and wireshark`
# RUN kubectl krew install starboard `# Toolkit for finding risks in kubernetes resources`
# RUN kubectl krew install status `# Show status details of a given resource`
# RUN kubectl krew install tap `# Interactively proxy Kubernetes Services with ease`
# RUN kubectl krew install tree `# Show a tree of object hierarchies through ownerReferences`
# RUN kubectl krew install tunnel `# Reverse tunneling between cluster and your machine (also see telepresence)`
# RUN kubectl krew install unused-volumes `# List unused PVCs`
# RUN kubectl krew install view-secret	`# Decode Kubernetes secrets`
# RUN kubectl krew install warp `# Sync and execute local files in Pod`
# RUN kubectl krew install who-can	`# Shows who has RBAC permissions to access Kubernetes resources`
# RUN kubectl krew install whoami `# Show the subject that's currently authenticated as`

## Install ohmyzsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Copy zsh files to /usr/share for all uer access
RUN mv /root/.oh-my-zsh /usr/share/oh-my-zsh
# Copy our zshrc into the dir (which will be the default for users)
COPY /dockerroot/root/.zshrc /usr/share/oh-my-zsh/zshrc

# Create hard link to the zshrc file so it creates an actual independent copy on new users
RUN mkdir -p /etc/skel/ && ln /usr/share/oh-my-zsh/zshrc /etc/skel/.zshrc

# TODO: make oh-my-zsh work for every user (maybe via an entrypoint script?)

COPY /dockerroot/ /

CMD [ "zsh" ]
