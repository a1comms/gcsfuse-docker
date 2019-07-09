# gcsfuse-docker

Docker image for mounting GCS buckets, designed to be used with Kubernetes and workload identity (so no key file required).

Container must be started as privileged for mount to succeed.

The easiest way to use this to mount a single bucket would be to use the `gcsfuse` mount command directly:

```
FROM gcr.io/...../gcsfuse-docker

CMD ["gcsfuse", "--foreground", "-o", "allow_other", "BUCKET-NAME", "/mnt"]
```

Or for Kubernetes:

```yaml
example to follow...
```