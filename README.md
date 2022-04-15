# NY-internal-k8s-training-materials

This repo contains the internal Kubernetes traininng materials.

## Slides

- [Kubernetes Training: Part 1][1]:
  - What's Kubernetes?
  - Architecture and terminologies
  - Namespace
  - Pod
  - Pod and Common Worklods
  - Labels and Annotations
  - ConfigMap
  - Secret

- [Kubernetes Training: Part 2][2]:
  - Connectivity
    - Service & Load Balancing
    - Ingress & Ingress Controller
  - Pod Lifecyle
    - Lifecycle
    - Probe
    - Graceful Shutdown
  - Horizontal Pod Autoscaler
  - Trouble Shooting
    - OOMKilled
    - ImagePullBackOff
    - CrashLoopBackOff
    - CreateContainerConfigError


## Provisioning

When using AWS Cloud9, simply run the following script:

```bash
$ cd provisioning
$ ./provision.sh
```

It will extend EBS size to 100GiB, then install tools like kubectl and k3d to complete the labs of this training.

[1]: https://docs.google.com/presentation/d/1yGdsDwq5BSf5Rf3WvciiZOy0Fgq80LgMi4IsAF9nqT4/edit#slide=id.gdf8ff4bb1d_0_0
[2]: https://docs.google.com/presentation/d/1B-DntJk7K2Las7B_n2MWA2sy7acnVY2dnfRU2bYpK_Q/edit#slide=id.gdd983ebc7c_0_0
