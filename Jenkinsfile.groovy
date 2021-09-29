pipeline{
    agent any
    stages{
        stage("run packer"){
            steps{
              sh "packer init image.pkr.hcl"
              sh "packer build image.pkr.hcl"
            }
            
        }
    }

}