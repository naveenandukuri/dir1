pipeline() {
agent any
stages(){
stage("git init"){
steps{
checkout changelog: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/naveenandukuri/dir1.git']])
}
}
stage("maven"){
steps{
h "mvn clean package"
}
}

stage("sonar"){
steps{
sh '''mvn sonar:sonar \\
  -Dsonar.projectKey=mavenproj \\
  -Dsonar.host.url=http://3.128.78.26:9000 \\
  -Dsonar.login=1a69a088bede4a7cdef143e7b233bb59fee08ecb'''
}
}
stage("nexus"){
steps{
nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS-CRED', groupId: 'QA', nexusUrl: '3.144.94.72:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'test', version: '$BUILD_ID'
}
}
stage("tomcat"){
steps{
deploy adapters: [tomcat9(credentialsId: 'TOMCAT-CRED', path: '', url: 'http://18.188.53.16:8080/')], contextPath: 'webapp/target/webapp.war', onFailure: false, war: '**/*.war'
}
}


