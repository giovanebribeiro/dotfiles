#!/usr/bin/env python3

import subprocess
import sys

def ensure_package_installed(package_name):
    """
    Checks if a Python package is installed. If not, it installs the package using pip.

    Args:
        package_name (str): The name of the package to check and install.
    """
    try:
        # Attempt to import the package to check if it's installed
        __import__(package_name)
        print(f"Package '{package_name}' is already installed.")
    except ImportError:
        print(f"Package '{package_name}' not found. Installing...")
        try:
            # Use subprocess to run the pip install command
            subprocess.check_call([sys.executable, "-m", "pip", "install", package_name])
            print(f"Package '{package_name}' installed successfully.")
        except subprocess.CalledProcessError as e:
            print(f"Error installing package '{package_name}': {e}")
        except FileNotFoundError:
            print("Error: pip command not found. Ensure pip is installed and in your PATH.")

ensure_package_installed("qrcode")

import qrcode
import argparse

# 1. Create an ArgumentParser object
parser = argparse.ArgumentParser(description="A simple program that generates a QRCode from an URL.")

# 2. Add arguments
# Positional argument: 'name'
parser.add_argument("data", help="The data to be encoded")

# Optional argument: '--type' (The type of data to encode)
parser.add_argument("--type", type=str, choices=['url', 'text'], default="url", help="Type of data to encode. Possible values: url, text. Default: url")

# Data to be encoded in the QR code
args = parser.parse_args()

qr_version = 1 # smallest
if args.type == 'text':
    qr_version = 40

# Create a QR code instance
qr = qrcode.QRCode(
    version=qr_version,  # Controls the size of the QR Code (1 is the smallest, 40 is the largest)
    error_correction=qrcode.constants.ERROR_CORRECT_L, # Error correction level
    box_size=10,  # Size of each box in the QR code
    border=4,  # Border size around the QR code
)

# Add data to the QR code
qr.add_data(args.data)
qr.make(fit=True)

# Create an image from the QR code instance
img = qr.make_image(fill_color="black", back_color="white")

qr_filename = "my_qrcode"

# Save the image as a PNG file
img.save(f"{qr_filename}.png")

print(f"QR code saved as {qr_filename}.png")
