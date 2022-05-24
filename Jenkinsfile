pipeline {
  agent any

  environment {
    REGISTRY_URL = 'public.ecr.aws/r7m7o9d4'
    ECR_REGION = 'eu-north-1'
    K8S_CLUSTER_NAME = 'ci-cd-demo-k8s'
    K8S_CLUSTER_REGION = 'eu-north-1'
  }

  stages {
    stage('Webserver - build'){
        when { branch "main" }
        steps {
            sh '''
            IMAGE="flask-server:0.0.${BUILD_NUMBER}"
            cd ml_model
            aws ecr get-login-password --region $ECR_REGION | docker login --username AWS --password-stdin ${REGISTRY_URL}
            docker build -t ${IMAGE} .
            docker tag ${IMAGE} ${REGISTRY_URL}/${IMAGE}
            docker push ${REGISTRY_URL}/${IMAGE}
            '''
        }
    }

    stage('Webserver - deploy'){
        when { branch "main" }
        steps {
            sh '''
            cd infra/k8s
            IMG_NAME=flask-server:0.0.${BUILD_NUMBER}

            # get kubeconfig creds
            aws eks --region $K8S_CLUSTER_REGION update-kubeconfig --name $K8S_CLUSTER_NAME

            # apply to your namespace
            kubectl apply -f flask-server.yaml
            '''
        }
    }
  }
}


