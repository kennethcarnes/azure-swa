import os

print("Starting script...")

# Read the storage account name from the environment variable
storage_account_name = os.environ.get("STORAGE_ACCOUNT_NAME")
blob_container_name = os.environ.get("BLOB_CONTAINER_NAME")

print(f"Storage Account: {storage_account_name}")
print(f"Blob Container: {blob_container_name}")

print("Current Directory:", os.getcwd())
print("Directory Contents:", os.listdir())

# Read HTML file into memory 
with open("src/index.html", "r") as file:
    content = file.read()
    print(f"File content: {content[:100]}...")  # print only the first 100 characters

# Replace placeholders with Blob Storage URLs
content = content.replace("PHOTO_PLACEHOLDER", f"https://{storage_account_name}.blob.core.windows.net/{blob_container_name}/Photo.jpg")
content = content.replace("RESUME_PLACEHOLDER", f"https://{storage_account_name}.blob.core.windows.net/{blob_container_name}/Kenneth-Carnes-Resume.pdf")

# Write updated HTML back to file
with open("src/index.html", "w") as file:
    file.write(content)

print("Finished script...")
