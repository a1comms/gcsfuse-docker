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
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: my-application
  name: my-application
spec:
  selector:
    matchLabels:
      app: my-application
  template:
    metadata:
      labels:
        app: my-application
    spec:
      containers:
      - image: gcr.io/..../application:version
        imagePullPolicy: Always
        name: application
        volumeMounts:
        - mountPath: /usr/src/redmine/files
          mountPropagation: HostToContainer
          name: web-data
      - command:
        - gcsfuse
        - --foreground
        - -o
        - allow_other
        - BUCKET-NAME
        - /mnt
        image: gcr.io/..../gcsfuse-docker:version
        imagePullPolicy: Always
        lifecycle:
          preStop:
            exec:
              command:
              - umount
              - /mnt
        name: sidecar-gcsfuse
        resources:
          requests:
            cpu: 10m
        securityContext:
          capabilities:
            add:
            - SYS_ADMIN
          privileged: true
        volumeMounts:
        - mountPath: /mnt
          mountPropagation: Bidirectional
          name: web-data
      restartPolicy: Always
      volumes:
      - emptyDir: {}
        name: web-data
```
