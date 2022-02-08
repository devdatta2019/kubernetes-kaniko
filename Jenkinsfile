def dockerImage
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
      def app
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
              script {
                    def commit = checkout scm
                    // we set BRANCH_NAME to make when { branch } syntax work without multibranch job
                    env.BRANCH_NAME = commit.GIT_BRANCH.replace('origin/', '')

                    dockerImage = docker.build("myImage:${env.BUILD_ID}",
                        "--label \"GIT_COMMIT=${env.GIT_COMMIT}\""
                        + " --build-arg MY_ARG=myArg"
                        + " ."
                    )
            
          
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
}


}
