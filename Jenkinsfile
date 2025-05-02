pipeline {
  agent any


  environment {
    FIREBASE_TOKEN = credentials('FIREBASE_TOKEN') // firebase token configured the jenkins credentials
  }

  tools {
    git 'Default' 
    nodejs 'NodeJS_20' // Set this name in Jenkins > Global Tool Configuration
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/lalu2019/AngularPipeline.git', branch: 'main'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm install'
      }
    }

    // stage('Lint') {
    //   steps {
    //     sh 'npm run lint'
    //   }
    // }

    stage('Build') {
      steps {
        sh 'npm run build --configuration=production'
      }
    }

    stage('Test') {
      steps {
        sh 'npm run test -- --watch=false --browsers=ChromeHeadless'
      }
    }

    stage('Deploy or Archive') {
      steps {
        archiveArtifacts artifacts: 'dist/**', fingerprint: true
      }
    }
    stage('Deploy to Firebase') {
      steps {
        sh 'npm install -g firebase-tools'
        sh "firebase deploy --only hosting --token \"$FIREBASE_TOKEN\""
      }
    }
  }
}
