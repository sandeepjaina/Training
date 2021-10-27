pipeline {
    agent {
     node { label 'controller' }
    }
    parameters {
        choice(name: 'action', choices: ['Apply', 'Destroy'], description: 'Please pick an action for terraform')
    }
    options{
        ansiColor('xterm')
    }

    stages{
        stage('Terraform init'){
            steps{
                sh '''
                #cd multi_env
                #terraform init -backend-config=env/dev-backend.tfvars
                cd roboshop
                terraform init
                '''
            }
        }

        stage('Terraform Apply'){
            when {
                environment name: 'action', value: 'Apply'
            }
            steps{
                sh '''
                #cd multi_env
               #terraform apply -auto-approve -var-file=env/dev.tfvars
                  cd roboshop
                  terraform apply -auto-approve
                '''
            }

        }
        stage('Terraform Destroy'){
            when {
                environment name: 'action', value: 'Destroy'
            }
            steps{
                sh '''
             # cd multi_env
             #terraform destroy -auto-approve -var-file=env/dev.tfvars
                   cd roboshop
                   terraform destroy -auto-approve
                '''
            }

        }
    }

}