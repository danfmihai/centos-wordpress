pipeline{
    agent any
    stages{
        stage("Packer - Build ec2 image for Wordpress"){
            steps{
              sh """
              #!/bin/bash
              packer init -var-file=variables.pkr.hcl image.pkr.hcl
              packer build -var-file=variables.pkr.hcl image.pkr.hcl
              """
            }
            
        }
    }

}