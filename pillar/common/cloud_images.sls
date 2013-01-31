#!yaml

# List of cloud images per vm provider, 
# organized by os and region.

cloud_images:
  aws:

    # Ubuntu 12.04 LTS AMI's
    # Updated list found here: 
    # http://cloud-images.ubuntu.com/releases/precise/release/
    # Example usage: pillar['cloud_images']['aws']['ubuntu']['1204_LTS']

    Ubuntu:
      12_04_LTS:
        us-west-1: ami-b87252fd
        us-west-2: ami-7e2da54e
        us-east-1: ami-e720ad8e
        sa-east-1: ami-97eb338a
        eu-west-1: ami-940f03e0
        ap-southeast-1: ami-03226051
        ap-southeast-2: ami-7d7ee947
        ap-northeast-1: ami-c0a912c1

    