# Lab 02

## Purpose

1. This lab will guide you to create your first job and cronjob.
2. Check the replicasets' change and how rollout is done.

## Set up

Watch CronJob, Job, and Pods in another terminal (or use `tmux`):

```sh
$ watch -n 1 kubectl get cj,job,pod
```

Note: `cj` is the short form of `cronjob`.

For more API resources, check `$ kubectl api-resources`.

## Create Jobs using...Job

1. Create job using `kubectl`:

    ```sh
    $ kubectl apply -f ./get-random-user-job.yaml
    ```

1. Check how many parallel jobs are executing at the same time


1. Check Logs of these finished pods:

    ```sh
    $ kubectl logs -l app=get-random-user
    ```

1. Clean up:

    ```sh
    $ kubectl delete -f get-random-user-job.yaml
    ```

## Use CronJob for periodic Job execution

1. Create CronJob using `kubectl`

    ```sh
    $ kubectl apply -f get-random-user-cron-job.yaml
    ```

1. In another terminal window, check the pods' logs:

    ```sh
    $ watch -n 1 kubectl logs -l app=get-random-user-cj
    ```

1. Clean up:

    ```sh
    $ kubectl delete -f get-random-user-cron-job.yaml
    ```
