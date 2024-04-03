ARG ALPINE_VERSION

FROM --platform=$BUILDPLATFORM mheers/alpine-tools:${ALPINE_VERSION} as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM

USER root
ENV PATH "$PATH:/root/.arkade/bin/"

RUN apk add \
    docker \
    file \
    fzf \
    zsh

## Install arkade
# RUN curl -sLS https://get.arkade.dev | sh

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
    wget https://github.com/alexellis/arkade/releases/download/0.10.16/arkade -O /usr/local/bin/arkade; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
    wget https://github.com/alexellis/arkade/releases/download/0.10.16/arkade-arm64 -O /usr/local/bin/arkade; \
    else \
    echo "Unsupported platform: $TARGETPLATFORM"; exit 1; \
    fi \
    && chmod +x /usr/local/bin/arkade \
    && ln -s /usr/local/bin/arkade /usr/local/bin/ark


RUN /usr/local/bin/arkade --help
# RUN ark --help  # a handy alias


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
RUN ark get --quiet promtool `# prometheus rule tester`
# RUN ark get --quiet terraform `# needed? infrastructure as code`
RUN ark get --quiet vault `# vault cli`
RUN ark get --quiet yq `# yaml parser / manipulator`

RUN chmod 777 /root/.arkade/bin/* && mv /root/.arkade/bin/* /usr/local/bin/

ENV KREW_ROOT="/usr/local/krew/"
ENV PATH "$PATH:/usr/local/krew/bin/"

## Install krew plugins
RUN krew install krew
# RUN kubectl krew install access-matrix `# show an RBAC access matrix for server resources`
# RUN kubectl krew install azad-proxy `# Generate and handle authentication for Azure AD`
RUN kubectl krew install cert-manager `# Manage cert-manager resources inside your cluster`
# RUN kubectl krew install cilium `# Easily interact with Cilium agents`
# RUN kubectl krew install config-cleanup `# Automatically clean up your kubeconfig`
RUN kubectl krew install config-registry `# Switch between kubeconfig files`
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
# RUN kubectl krew install hns `# Manage hierarchical namespaces`
RUN kubectl krew install images `# Show container images used in the cluster`
# RUN kubectl krew install janitor `# Lists objects in a problematic state`
RUN kubectl krew install konfig `# Manage kubeconfig files`
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

RUN chmod 777 -R /usr/local/krew/store/

## Install the Pulumi SDK, including the CLI and language runtimes.
RUN curl -fsSL https://get.pulumi.com/ | bash -s -- --version $PULUMI_VERSION && \
    mv ~/.pulumi/bin/* /usr/bin

ENV PULUMI_KUBE2PULUMI_VERSION=v4.9.1
ENV PULUMI_KUBE2PULUMI_RELEASE=v0.0.17
## Install the Pulumi kube2pulumi plugin.
RUN pulumi plugin install resource kubernetes $PULUMI_KUBE2PULUMI_VERSION
RUN export TP=${TARGETPLATFORM//\//-} && wget https://github.com/pulumi/kube2pulumi/releases/download/$PULUMI_KUBE2PULUMI_RELEASE/kube2pulumi-$PULUMI_KUBE2PULUMI_RELEASE-$TP.tar.gz && \
    tar -xvf kube2pulumi-$PULUMI_KUBE2PULUMI_RELEASE-$TP.tar.gz && \
    mv kube2pulumi /usr/bin

## Install ohmyzsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 

## Copy zsh files to /usr/share for all uer access
RUN cp -r /root/.oh-my-zsh /usr/share/oh-my-zsh
## Copy our zshrc into the dir (which will be the default for users)
COPY /dockerroot/root/.zshrc /usr/share/oh-my-zsh/

COPY --from=mheers/k3dnifi /usr/bin/k3dnifi /usr/bin/k3dnifi
COPY --from=mheers/k3droot /usr/bin/k3droot /usr/bin/k3droot
COPY --from=mheers/kubeyaml /usr/bin/kubeyaml /usr/bin/kubeyaml
COPY --from=mheers/pulumi-helper /usr/bin/pulumi-helper /usr/bin/pulumi-helper
COPY --from=aquasec/trivy:0.50.1 /usr/local/bin/trivy /usr/bin/trivy

RUN mkdir -p /tmp/.cache && chmod 777 /tmp/.cache

FROM --platform=$BUILDPLATFORM golang:1.22.1-alpine3.19 as go
COPY --from=builder / /
RUN go install github.com/remotemobprogramming/mob/v3@latest
RUN go install github.com/smallstep/cli/cmd/step@latest


FROM --platform=$BUILDPLATFORM scratch
COPY --from=go / /

ENV KREW_ROOT="/usr/local/krew/"
ENV PATH "$PATH:/usr/local/krew/bin/:/go/bin:/usr/local/go/bin"
ENV ZDOTDIR /usr/share/oh-my-zsh/
ENV XDG_CACHE_HOME /tmp/.cache

CMD [ "zsh" ]
