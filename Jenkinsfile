podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: kaniko
        image: gcr.io/kaniko-project/executor:v1.20.0-debug
        command:
        - sleep
        args: 
        - 99d
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      nodeSelector: 
        kubernetes.io/arch: amd64
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('checkout SCM') {  
      checkout scm
    }
    stage('Build Docker Image') {
      container('kaniko') {
        sh '''
          /kaniko/executor --force --log-format=text --context `pwd` --destination registry.stiil.dk/library/php-fpm-nextcloud:$BRANCH_NAME
        '''
      }
    }
  }
}