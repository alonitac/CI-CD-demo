pipeline {
  agent any

  environment {
    REGISTRY_URL = 'public.ecr.aws/r7m7o9d4'
    K8S_CLUSTER_NAME = 'ci-cd-demo-k8s'
    K8S_CLUSTER_REGION = 'eu-north-1'
  }

  stages {
    stage('Webserver - build'){
        when { branch "main" }
        steps {
            sh '''
            echo "running..."
            '''
        }
    }


  }
}


