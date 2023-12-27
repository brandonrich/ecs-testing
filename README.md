This repo contains a simple Dockerfile that runs nginx.  There are three components:
- `Dockerfile`
- `nginx.conf`
- `index.html`

Make sure your terminaal is at the root and Docker is running.  Then, let's build the container image.

```
docker build -t my-nginx-image .
```

Test it locally if you want by doing this...
```
docker run -d -p 8080:80 my-nginx-image
```
and then visiting http://localhost:8080

Now, we want to push this to AWS so we can run it on ECS.  First, we need to create a repo in the Elastic Container Registry.  To create the ECR repo, run `cloudformation_ecr.yml` in Cloudformation.

To log in to ECR, get to a terminal that is already authenticated to the target AWS account (in this case, AILabND).  You can do this by visiting awsconsole.nd.edu and copying the temporary credentials for the terminal into your environment.  **Make sure docker is running locally**, then do this:
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 031878740168.dkr.ecr.us-east-1.amazonaws.com
```

Note the hard-coded ECR URI.  

Now let's build and tag for ECR.
```
docker build -t my-nginx-repo .
docker tag my-nginx-repo:latest 031878740168.dkr.ecr.us-east-1.amazonaws.com/my-nginx-repo:latest
```
...and push!

```
docker push 031878740168.dkr.ecr.us-east-1.amazonaws.com/my-nginx-repo:latest
```

Let's confirm that worked:

```
aws ecr list-images --repository-name my-nginx-repo --region us-east-1
```

You should see the "latest" tag.