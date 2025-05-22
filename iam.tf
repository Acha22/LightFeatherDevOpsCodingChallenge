# Create role
resource "aws_iam_role" "ecs_admin_access" {
  name        = "ECS_Admin_Role"
  description = "Allow jenkins to use ECS"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Attach policy
resource "aws_iam_policy_attachment" "ecs_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  name       = "ecs_full_access_policy_attachment"
  roles      = [aws_iam_role.ecs_admin_access.name]
  # depends_on = [aws_iam_role.ecs_admin_access]
}

# Create instance profile
resource "aws_iam_instance_profile" "jenkns_instace_profile" {
  name = "Jenkins-Instance-Profile"
  role = aws_iam_role.ecs_admin_access.name
  # depends_on = [aws_iam_policy_attachment.ecs_full_access]
}