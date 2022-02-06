podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: maven
        image: maven:3.8.1-jdk-8
        command:
        - sleep
        args:
        - 99d
      - name: ubuntu
        image: ubuntu:latest
        command:
        - sleep
        args:
        - 99d
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Get a Maven project') {
      git url: 'https://github.com/scriptcamp/kubernetes-kaniko.git', branch: 'main'
      container('maven') {
        stage('Build a Maven project') {
          sh '''
          echo pwd
          '''
        }
      }
    }

    stage('Build Java Image') {
      container('kaniko') {
        stage('Build a Go project') {
          sh '''
            /kaniko/executor --context `pwd` --no-push
          '''
        }
      }
    }
 stage('prismaCloud-example-builder') { 
      container('ubuntu') {
          stage ('Prisma Cloud scan') {
              prismaCloudScanImage ca: '',
                    cert: '',
                    image: 'alpine',
                    ignoreImageBuildTime: true,
                    key: '',
                    logLevel: 'info',
                    podmanPath: '',
                    project: '',
                    resultsFile: 'prisma-cloud-scan-results.json'
                   
                
          }
       
      }
   } 
      
                          
      stage ('Prisma Cloud publish') {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
    }   
    
  }
}

