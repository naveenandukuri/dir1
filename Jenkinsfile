pipeline() {
agent any
stages(){
stage("git init"){
steps{
checkout changelog: false, scm: scmGit(branches: [[name: '*/fet1']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/naveenandukuri/dir1.git']])
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
  -Dsonar.host.url=http://18.191.51.1:9000 \\
  -Dsonar.login=8dcdd34743b22551daca4905329566e8e001679c'''
}
}
stage("nexus"){
steps{
nexusArtifactUploader artifacts: [[artifactId: '$BUILD_TIMESTAMP', classifier: '', file: 'webapp/target/webapp.war', type: 'war']], credentialsId: 'NEXUS-CRED', groupId: 'QAT', nexusUrl: '3.145.44.12:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'test1', version: '$BUILD_ID'
}
}
stage("tomcat"){
steps{
deploy adapters: [tomcat9(path: '', url: 'http://18.220.117.197:8080/')], contextPath: 'qaenv', onFailure: false, war: '**/*.war'
}
}


