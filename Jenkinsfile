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
            /kaniko/executor --context `pwd` --destination devdatta1987/hello-kaniko:1.3
          '''
        }
      }
    }
     
stage('Check twistcli version') {

  def TCLI_VERSION = sh(script: "./twistcli | grep -A1 VERSION | sed 1d", returnStdout:true).trim()
  def CONSOLE_VERSION = sh(script: "curl -k -u \"f04d752e-26fd-4c43-b4ec-0b1a96d60ad7:Fd541jRnVmlYnrsn3H0Onu+al28=\" https://https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/version | tr -d \'\"'", returnStdout:true).trim()

  println "TCLI_VERSION = $TCLI_VERSION"
  println "CONSOLE_VERSION = $CONSOLE_VERSION"

  if ("$TCLI_VERSION" != "$CONSOLE_VERSION") {
    println "downloading twistcli"
    sh 'curl -k -u f04d752e-26fd-4c43-b4ec-0b1a96d60ad7:Fd541jRnVmlYnrsn3H0Onu+al28= --output ./twistcli https://https://https://us-west1.cloud.twistlock.com/us-3-159181236/api/v1/util/twistcli'
    sh 'sudo chmod a+x ./twistcli'
  }
}

      
stage('Scan with Twistcli') {
  sh './twistcli images scan --address https://us-west1.cloud.twistlock.com/us-3-159181236 -u f04d752e-26fd-4c43-b4ec-0b1a96d60ad7 -p Fd541jRnVmlYnrsn3H0Onu+al28= --details devdatta1987/hello-kaniko'
}      
  } 
}   
      
      
  

