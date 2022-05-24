pipeline {
  agent any

  environment {
    REGISTRY_URL = '352708296901.dkr.ecr.eu-north-1.amazonaws.com'
    K8S_CLUSTER_NAME = 'ci-cd-demo-k8s'
    K8S_CLUSTER_REGION = 'eu-north-1'
  }

  stages {
    stage('Webserver - build'){
        when { branch "main" }
        steps {
            sh '''
            IMAGE="flask-server:0.0.${BUILD_NUMBER}"
            aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin ${REGISTRY_URL}
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
            IMG_NAME=flask-server:0.0.${BUILD_NUMBER}

            # get kubeconfig creds
            aws eks --region $K8S_CLUSTER_REGION update-kubeconfig --name $K8S_CLUSTER_NAME

            sed -i "s/{{IMG_NAME}}/$IMG_NAME/g" flask-webserver.yaml

            # apply to your namespace
            kubectl apply -f flask-webserver.yaml
            '''
        }
    }
  }
}


