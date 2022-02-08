def scmvars
def image
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
        image: rancher/dind
        command:
        - sleep
        args:
        - 9999999
        
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
      container('dind') {
        stage('Build a Go project') {
          // arg 1 is the image name and tag
        // arg 2 is docker build command line
        image = docker.build("com.mycompany.myproject/my-image:${env.BUILD_ID}",
              " --build-arg commit=${scmvars.GIT_COMMIT}"
            + " --build-arg http_proxy=${env.http_proxy}"
            + " --build-arg https_proxy=${env.https_proxy}"
            + " --build-arg no_proxy=${env.no_proxy}"
            + " path/to/dir/with/Dockerfile")
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

