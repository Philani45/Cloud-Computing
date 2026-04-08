@ -78,25 +78,53 @@ terraform apply
When apply is complete, Terraform outputs the ALB DNS name (`dns_name`).
Open that URL in a browser to verify traffic routing.

## 6) Common customizations

- Change instance size in `c7-01-ec2instance-variables.tf`.
- Change CIDR/subnet layout in `c4-01-vpc-variables.tf`.
- Tighten ingress rules in SG files under `c5-*`.
- Update health check path in `c11-02-ALB-application-loadbalancer.tf` to match your app route.

## 7) Validation checklist

- `terraform validate` passes.
- ALB target group shows healthy targets.
- ALB DNS endpoint is reachable.
- Repeated requests hit both backends (if app displays server identity).

## 8) Cleanup

To avoid ongoing AWS charges:

```bash
terraform destroy
```

## 9) Next step: make the website a clickable registration demo

After infrastructure is healthy, the next practical step is to replace static bootstrap content with a simple backend + frontend flow that users can click through during presentation.

Recommended sequence:

0. **Choose demo mode (Python backend optional)**
   - **Fast demo mode (no Python required):** keep Apache/Nginx and implement registration as static HTML/CSS/JS with mock success responses.
   - **Full workflow mode (Python recommended):** run Flask/FastAPI/Node backend if you need server-side validation, persistence, or API logging.
1. **Run the same app on both EC2 instances**
   - Serve one identical app version on each private instance behind ALB.
   - Keep a health endpoint (for example `/health`) that returns HTTP 200.
2. **Implement click-through registration pages**
   - Add a course list page with “Register” buttons.
   - Add a confirmation page that shows selected course, timestamp, and success status.
   - Use a minimal persistence option for demo (in-memory list or lightweight DB), depending on your scope.
3. **Align ALB health checks with your app route**
   - If app routes change, update target group `health_check.path` so both targets stay healthy.
4. **Show load balancing during the demo**
   - Display hostname or instance-id on responses to prove traffic reaches both EC2 instances.
   - Refresh repeatedly and capture alternating backend identity.
5. **Prepare a presenter validation script**
   - Open ALB DNS.
   - Click course registration path end-to-end.
   - Show successful confirmation message.
   - Show target group health and backend identity evidence.

For this repository specifically, `c7-04-ec2instance-private.tf` references `app1-install.sh` in `user_data`; replacing that bootstrap script with your app startup (or image pull + run) is the immediate implementation task for the CSC demo.
