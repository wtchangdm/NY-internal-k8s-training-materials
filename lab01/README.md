# Lab 01

## Purpose

1. This lab will guide you to create your first deployment.
1. Check the replicasets' change and how rollout is done.

## Meet Deployment, ReplicaSet and Pod

1. Create deployment using `kubectl`:

    ```sh
    $ kubectl apply -f ./echo.yaml
    ```
1. Watch ReplicaSet and Pod in another terminal (or use `tmux`):

    ```sh
    $ watch -n 1 kubectl get deploy,rs,pod
    ```

    Note: `deploy` is the short form of `deployment`. `rs` is the short form of `replicaset`.

    For more API resources, check `$ kubectl api-resources`

1. Get logs from the first pod:

    ```sh
    $ kubectl logs -f <pod_name>
    ```

1. Update image:

    ```sh
    $ kubectl set image deploy/echo echo=alpine
    ```

1. Observe the ReplicaSet's desired and current number.

1. Get logs from new pod, and check which ReplicaSet created the new pod:

    ```sh
    $ kubectl logs -f <new_pod_name>
    ```

## Scale replicas

1. Scale replicas to 3

    ```sh
    $ kubectl scale deploy/echo --replicas 3
    ```

1. Check ReplicasSet's desired and current number, and the pods.

## Cleanup:

```sh
$ kubectl delete -f ./echo.yaml
```
