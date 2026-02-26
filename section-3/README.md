# Task B – CI/CD pipeline is stuck

- Jenkins/GitLab CI pipeline is hanging for 30+ min.
- How would you debug it? What logs would you check? How to unblock it?

## GitLab CI

- First, check GitLab’s service health: https://status.gitlab.com/
- If GitLab CI/CD is operating normally, investigate the specific pipeline and job:
  - Navigate to the project CI/CD Pipelines page and open the affected pipeline.
- Check the logs: job trace, runner logs, executor logs, system logs
- Next, determine "what “stuck” means" for the job by looking at its status:
  - Pending / Waiting: the job has not started yet.
  - Common causes include no available runner, runner offline, tag mismatch, concurrency limits, or restrictions. In GitLab SaaS, this can also happen due to usage/minutes limits.
  - Manual: the pipeline is waiting for a manual approval/action.
- If the job did not start at all, verify the trigger conditions:
  - branch rules, merge request pipelines, schedules, or webhooks.
- To fix it, we can try following:
  1. Wait until gitlab is back up and rerun job
  2. Cancel and retry the job
  3. Manually approve action
  4. Fix the trigger and rerun it
