# Proof of concept for WebDAV-Containerization

This repo is a PoC for the combination of the WebDAV Protokoll and an Angular Development Server inside of an dockerized environment.

⚠️Do not use this in public accessible environment as **arbitrary code execution** attacks are possible in this environment

## What is this for?

This PoC is supposed to proof how WebDAV (using nginx) can be provided to host editable source code of an angular application, while a `ng serve` Angular development server is running in the background to rerender all changes made over WebDAV

## Getting startet

1. Build the docker image

```bash
docker build --tag dustdevdm/webdavtest .
```

2. start the container

```bash
docker run -p 80:80 -p 4200:4200 --name webdavtest dustdevdm/webdavtest
```

## How do u use this?

Simple! To see the angular application, open port 4200 of the maschine where the container is hosted in your browser.
You can use the WebDAV client of your choice to access the files. I prefer the [WebDAV Workspace](https://marketplace.visualstudio.com/items?itemName=kowd.vscode-webdav) plugin for visual studio code. You can use the `connect.code-workspace` file to use the extension after setting the right host.
