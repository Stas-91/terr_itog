spec:
  containers:
    - image: "${container_image}"
      securityContext:
        privileged: ${privileged}
      stdin: false
      tty: false
      env:
        - name: DB_HOST
          value: "${db_host}"
        - name: DB_USER
          value: "${db_user}"
        - name: DB_PASSWORD
          value: "${db_password}"
        - name: DB_NAME
          value: "${db_name}"
      restartPolicy:
        type: "Always"          