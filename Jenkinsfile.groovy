pipeline{
    agent any
    stages{
        stage("Packer - Build ec2 image for Wordpress"){
            steps{
              sh """
              #!/bin/bash
              packer init .
              packer build .
              """
            }
            
        }
    }

}