// 🔥 Firebase Plugin Classpath Configuration
buildscript {
    dependencies {
        // Firebase services plugin (required for google-services.json)
        classpath("com.google.gms:google-services:4.4.1")
    }

    repositories {
        google()
        mavenCentral()
    }
}

// 🔧 Common repositories block
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 🛠 Custom build directory settings (optional)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// 🧩 Ensure app project is evaluated properly
subprojects {
    project.evaluationDependsOn(":app")
}

// 🧹 Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
