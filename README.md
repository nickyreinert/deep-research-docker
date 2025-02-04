# deep-research-docker  
Docker setup to run **deep-research** in a container  

Although the **deep-research** project is already quite simple, I built a Docker container around it for easier setup and execution.  

## 🚀 Getting Started  
Clone this repository locally and run `setup.sh`:  

```bash  
git clone https://github.com/nickyreinert/deep-research-docker.git  
cd deep-research-docker
```
When done run the app. It will ask you for your API keys for **OpenAI** and **Firecrawl**:

- **OpenAI API Key:** Get it from [OpenAI's platform](https://platform.openai.com).  
- **Firecrawl API Key:** Register at [Firecrawl's website](https://firecrawl.com).  

```bash
bash setup.sh  
```

  Please fill in the values for FIRECRAWL_KEY and OPENAI_KEY in the .env.local file
  You can get the FIRECRAWL_KEY from https://firecrawl.com
  You can get the OPENAI_KEY from https://platform.openai.com
  Enter FIRECRAWL_KEY: 
  Enter OPENAI_KEY:

💡 **Both OpenAI and Firecrawl offer free-tier access**, allowing you to test without an initial cost!  

## ✅ Expected Output  
After a few seconds, you should see the following prompt:  

```  
What would you like to research?  
```  

Now you're ready to dive deep into your topic! 🚀
