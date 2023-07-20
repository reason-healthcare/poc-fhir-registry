# Using Verdaccio with FHIR Packages

This is a proof-of-concept using Verdaccio as a local FHIR registry. It is configured to uplink to packages.fhir.org as well as packages2.fhir.org.

## Running the server

Run the start script
```
./start.sh
```

Now make a working directory for the examples
```
mkdir test && cd test
```

## Example 1 - Installing a public package

```
npm --registry=http://127.0.0.1:4873 install hl7.fhir.us.core@5.0.1
```

Notice that in the local node_modules directory, you will see US Core package. To download the tarball only, you can run the following:
```
npm --registry=http://127.0.0.1:4873 pack hl7.fhir.us.core@5.0.1
```

Now you can clear out your test directory for the next example
```
cd .. && rm -rf test && mkdir test
```

## Example 2 - Publish a package with dependencies

First create a fake user on your local registry
```
npm --registry=http://127.0.0.1:4873 adduser
```
(fill in fake info)

Now in the fake-package directory, publish to your local registry
```
cd fake-package
```

(open package.json and notice the name has a scope, and depends on a number of
HL7 packages)

```
npm --registry=http://127.0.0.1:4873 publish
```

## Example 3 - Install a package with dependencies

Back in the now cleared test directory, install the new package you published:
```
npm  --registry=http://127.0.0.1:4873 install @acme/fhir.example@0.1.0
```

Notice in the `node_modules` directory, it installed the example package, as
well as all the dependencies.

---

NOTE: There are other ways to set the registry with `npm` client. There is an
ENV variable, as well as editing `.npmrc` file (globally or per-project).

NOTE2: Verdaccio shows how scopes can be used as a way to enforce permissions,
this is a common practice. Practical guidance for implementors could be to
always use scopes for non-public/non-HL7-ballot packages.
