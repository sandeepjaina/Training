//pipeline {
////    agent{
////        node { label 'centos' }
////    }
//
//    agent none
//
//
//    stages {
//        stage('one') {
//            agent {
//                label "workstation"
//            }
//            steps {
//                sh '''
//                 hostname
//                '''
//            }
//        }
//        stage('TWO') {
//            agent {
//                label "nodejs"
//            }
//            steps {
//                sh '''
//                 hostname
//                '''
//            }
//        }
//    }
//}

//
//pipeline {
//    agent any
//    tools {
//        maven 'Maven'
//    }
//    parameters {
//        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
//
//        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
//
//        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
//
//        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
//
//        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')}
//    environment {
//        Name = "google.com"
//        ssh = credentials('DevOps')
//    }
//    stages{
//        stage('ENV'){
//            environment {
//                Name = "yahoo.com"
//            }
//            steps {
//                sh 'echo ${Name}'
//                sh 'echo ${PERSON}'
//                sh 'echo ${BIOGRAPHY}'
//                sh 'echo ${TOGGLE}'
//                sh 'echo ${CHOICE}'
//                sh 'echo ${PERSON}'
//            }
//        }
//        stage('Tools')
//                {
//                    steps{
//                        sh 'mvn clean'
//                    }
//
//                }
//    }
//}

pipeline {
    agent any
    stages{
         stage('Normal'){
            steps {
                sh 'sleep 30'
            }
        }
        stage('parallel'){
            parallel{
                stage('Parallel 1'){
                    steps {
                        sh 'sleep 30'
                    }
                }

                stage('Parllel 2'){
                    steps {
                        sh 'sleep 30'
                    }
                }

            }

        }



        stage('Afer parllel'){
            steps {
                sh 'sleep 30'
            }
        }
    }
}