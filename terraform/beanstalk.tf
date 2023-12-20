data "aws_iam_role" "existing_role" {
  name = "aws-elasticbeanstalk-ec2-role"
}

resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = "my-elastic-beanstalk-instance-profile"
  role = data.aws_iam_role.existing_role.name
}

resource "aws_elastic_beanstalk_application" "pyapp" {
  name        = "todo-app"
  description = "My Elastic Beanstalk Application"
}

resource "aws_elastic_beanstalk_environment" "myenv" {
  name                = "development"
  application         = aws_elastic_beanstalk_application.pyapp.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.6 running Python 3.9" # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_instance_profile.name
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.rds_vpc.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "aws_subnet.rds_subnet_c"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.rds_sg.id
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = var.db_username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = var.db_password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = aws_rds_cluster.rds_cluster.endpoint
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PORT"
    value     = "3306"
  }
}
