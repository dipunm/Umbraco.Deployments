Umbraco.Deployments
===================
> *A new tool designed to help deployments.*

This tool aims to assist developers in making changes to the state of an existing Umbraco database via the Umbraco API. 
Other tools compare Umbraco instances and attempt to make decisions about what changes are necessary in order to synchronise.

During deployment, a developer and his/her team will know the changes that are going to be required within the CMS in order to complete the task of releasing their changes. The act of making these changes can be slow and laborious without an automated tool. Our tool attempts to solve the automation problem and leave the desisioning with the user.

Why build this tool?
---------------------
When maintaining our Umbraco sites, we found that code changes were often paired with changes within the database. 
These changes were often to do with adding new document types, data types, templates, or even amending them.

We initially tried different existing tools to accomplish the task of automating these changes as we deployed our code to our isolated environments, but they had their limitations. Ultimately, we fell back to writing manual deployment instructions and manually following these steps between releases.

#####Courier: 
- Courier is a very complex tool and has been unreliable in the past. 
- It compares two instances of Umbraco and tries to work out the differences. 
- It is a very powerful tool, and it allows the user to clearly see what is happening at each step. 
- For our use, it achieved many things outside the scope of our needs (such as file and assembly synchronisation) 
- It is controlled via a GUI, which means lots of mouse clicking.
- It did not always work out the differences well enough.

#####USync:
- USync's main objective is to allow developers to save the state of certain entities within the database to a file.
- This allows developers to keep a track of changes via version control.
- USync also allows file to db synchronisation. 
- This feature attempts to re-shape certain entities within the database to align it with the file.
- Our thoughts were to use this feature to automate deployments
- USync also tries to infer differences between two static states and attempts to automatically resolve these differences.
- USync will attempt to refrain from making breaking changes such as deletions.

#####Diagnosis:
The limitation of these tools is that neither know the history of changes made within the Umbraco instances. These tools do not know, yet they try to predict. During development, a developer and his/her team should already know the changes that are going to be required within the CMS in order to complete deployment. The act of making these changes to another Umbraco instance which has an older state can be slow and laborious and error prone without an automated tool. Our tool attempts to solve the automation problem and leave the desisioning with the user.
