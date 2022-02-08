def registry = "YourDockerhubAccount/YourRepository"
def registryCredential = 'dockerhub_id'
def dockerImage = 


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
      - name: dind
        image:  rancher/dind
        command:
        - sleep
        args:
        - 9999999
      restartPolicy: Never
     - name: git
       image: bitnami/git
       command:
        - sleep
        args:
        - 99d
      
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
    stage('Cloning our Git') {
        container('git') {  
git 'https://github.com/scriptcamp/kubernetes-kaniko.git'  
        }
    } 
  }           
    stage('Build Java Image') {
      container('dind') {
        stage('Build a Go project') {
          script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
          
        }
      }
    }
 stage('prismaCloud-example-builder') { 
      container('ubuntu') {
           stage ('Prisma Cloud scan') { 
        prismaCloudScanImage ca: '',
                    cert: '',
                    image: 'nginx',
                    ignoreImageBuildTime: true,
                    key: '',
                    logLevel: 'info',
                    podmanPath: '',
                    project: '',
                    resultsFile: 'prisma-cloud-scan-results.json'
                 
    }

    stage ('Prisma Cloud publish') {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
    }
  }
}
      
                          
      stage ('Prisma Cloud publish') {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
    }   
    
  }

