# Kawa maven plugin example project

This is an example project of using kawa maven plugin. The project consists of two subprojects - library and application.

Library project
* exposes a r7rs scheme library to be used in other r7rs/kawa projects,
* uses java library dependencies, automatically downloaded from maven central repository, to implement needed functionality,
* defines unit tests.

Application project
* uses library subproject as a dependency,
* defines main entry point.

## Use cases

### Run REPL in library project

Execute command inside `library` dir:

```
mvn kawa:compile kawa:repl
```

A kawa REPL should start, with all java maven dependencies on path, and with library being ready to import.
Execute following scheme code to see it reaches java dependencies:

```
(import (class org.apache.commons.math3.distribution NormalDistribution))
((NormalDistribution 0 1):cumulativeProbability 0)
```
and you should see output `0.5`.

Execute following scheme code to see it reaches library code:

```
(import (math normal-distribution))
(cumulative-probability 0 1 0)
```
and you should see output `0.5` again.

### Run unit tests in library project

Execute command insde `library` dir:

```
mvn clean test
```

A test suite should successfuly complete. You should see green "BUILD SUCCESS" at the bottom, and slightly above that a line "# of expected passes 1".

Let's see what happens of test failures. 

Open file library/src/test/scheme/main-test.scm, and change the line 

```
(test-assert (= 0.5 (cumulative-probability 0 1 0)))
```

to 

```
(test-assert (= 0.6 (cumulative-probability 0 1 0)))
```

Execute command inside `library` dir: 

```
mvn clean test
```

A test suite should fail. You should see red "BUILD FAILURE" at the bottom, and slightly above that a line "# of unexpected failures 1".
Undo the previously changed line before proceeding.

### Install library project

Execute command inside `library` dir:

```
mvn clean install
```

You should see green "BUILD SUCCESS" at the bottom. The library now should be installed into your local maven repository, and be available to be used in other projects. Whether that's true will be evident when trying to run the application subproject.

### Run application project

First make sure library part is installed (see "Install library project").

Execute command inside `application` dir:

```
mvn kawa:run
```

You should see application running. Enter 0 for mean, 1 for standard deviation, 0 for x, and you should see output 0.5, after which program terminates.

### Compile application project to fatjar and run

First make sure library part is installed (see "Install library project").

Execute command inside `application` dir:

```
mvn clean package
```

You should see a fatjar (jar, with all depdencies embedded inside) created at `application/target/kawa-plugin-example-application-0.0.1-SNAPSHOT.jar`. 

Execute command inside `application` dir:

```
java -jar target/kawa-plugin-example-application-0.0.1-SNAPSHOT.jar
```

You should see application running.
