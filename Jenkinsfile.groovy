pipeline{
    agent any
    stages{
        stage("run packer"){
            steps{
              sh "packer init ."
              sh "packer build ."
            }
            
        }
    }

}