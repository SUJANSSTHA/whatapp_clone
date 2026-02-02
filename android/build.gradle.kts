allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
//  namespace = "com.example.whatapp_clone.libraryname"
subprojects {
    afterEvaluate {
        if (it.plugins.hasPlugin("com.android.library")) {
            it.android {
                if (!it.namespace.isPresent) {
                    it.namespace = "com.example.whatapp_clone"
                }
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
