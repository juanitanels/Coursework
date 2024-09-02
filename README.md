# ✨ Welcome to my GitHub! ✨
***The home for all my wonderful CFGDegree Assignments!***

<br>
<br>

## Hi, I'm Juanita 😊
I'm 22 year old recent graduate (2023) in Politics anad International Studies from the Univeristy of Warwick. Despite my degree, I have always been intrigued by technology and its endless possibilities hence why I decided it was time to start my coding journey! I'm so grateful for this CFGDegree opportunity as I will continue to learn, grow and meet more like-minded people!

### This is me!
<img src="IMG_2744.jpg" alt="Alt text" width="300">


<br>


### 👩🏾‍🦱 Facts About Me
- 🏀 My mum got inspiration for my name from Michael Jordan's ex-wife (so random😅)
- 🌃 I have lived in London my whole life #CityGirl
- 🍜 My favourite food is anything from the Asian cuisine
- 🎶 I am OBSESSED with music. R&B is my favourite genre!

<br>

### CFG Courses I Have Completed:
- Solving Problems with Python MOOC Sprint
- Intro to CVs and Applications MOOC Sprint
- Intro to Coding MOOC Sprint
- Introduction to Python and Apps Kictstarter Course
- Intro to Machine Learning MOOC Sprint

<br>

### 🖥️ My Projects
- [Superstore Exploratory Data Analysis](https://github.com/juanitanels/superstores-eda.git)
- [Spotify Data Visualisation](https://github.com/juanitanels/spotify-data-visualisation.git)
- [London Crime Statistics Exploratory Data Analysis](https://github.com/juanitanels/London-Crime-Stats-EDA.git)

<br> 

### My Use of GitHub
I will primarily use GitHub for:
- Version Control: Managing and organising my personal and professional projects
- Collaboration: Working with peers and mentors on open-source or communtity projects
- Documentation: Keeping detailed track of my coding journey and progress
- Work in Progress: Showcasing my current projects and receiving constructive feedback from the community

<br>

---

# 📝 Assignment Notes and Explanations

<br>

I already had a GitHub account made, so I was quite familiar with the use of repositories remotely. Above you can find my README.md which details some facts about me using different markdown formatting syntax!

Now I will use screenshots to evidence and explain the process of completing this assignment.

#### HEADIN

<img src="assignment screenshots/ss1.png" alt="Alt text" width="800">
I initially created a folder in my documents named CFG Assignments, ensured I was in the correct directory by using `cd` . I used the `ls -a` to check the files in the folder.

To create a new file, I used `nano` to create and open the editor for `new_file.py`. 

`git add` allowed me to move the file to the staging area. `git status` confirmed that my file was successfully added and was ready to be committed.

I committed my changes with a message using `git commit -m " "`  and used `git remote add origin` to link my local and remote repositories.

I ran into an issue when trying to run `git push` which I resolved by using a YouTube tutorial to help me create an SSH key which then allowed me to clone my remote repository, creating a new folder for me to work in.

<br>

<img src="assignment screenshots/ss2.png" alt="Alt text" width="800">

<br>

This meant I was starting somewhat from scratch again so I will now paste some screenshots of the similar process but for the correct repository.

<img src="assignment screenshots/ss3.png" alt="Alt text" width="800">

<br>

This screenshot demonstrates that I was successfully able to push my local repository to my remote repository using `git push` .

I then used `git branch` to create a new branch and `git switch` to switch from main to the newly created branch.

`git branch` enabled me to view a list of all my branches.

<br>

<img src="assignment screenshots/ss4.png" alt="Alt text" width="800">

<br>

<img src="assignment screenshots/ss5.png" alt="Alt text" width="800">

<br>

I created a second new branch called ‘dummy-branch’ to repeat the process of creating a new file (`dummy-doc.py`) to add to the branch. This time, I used `touch` instead of `nano` which allowed me to create an empty file without opening it up.

I then used the command `git push --set-upstream origin dummy-branch` to push my new local branch to my remote repository.

<br>

<img src="assignment screenshots/ss6.png" alt="Alt text" width="800">

<br>

I then did the same for my ‘feature’ branch.

<br>

<img src="assignment screenshots/ss7.png" alt="Alt text" width="800">

<br>

After everything was pushed to the remote repository, GitHub prompted me to compare the branches and open a pull request.

This request was for merging my dummy-branch to main to add in the `dummy-doc.py` .

<br>

<img src="assignment screenshots/ss8.png" alt="Alt text" width="800">

<br>

It is important to be completely ready to put in a merge request, since once it is made and confirmed, it cannot be undone. The point of a pull request is to review the potential adjustments/changes, get a second opinion and review for final merge. This reviewer is usually assigned as a ‘Collaborator’. However, for the sake of this demonstration, there is no collaborator and I assigned myself as the reviewer.

<br>

<img src="assignment screenshots/ss9.png" alt="Alt text" width="800">

<br>

GitHub questions you multiple times to confirm whether you are truly ready to complete the merge, ensuring you can’t ‘mistakenly’ merge your branches when you didn’t intend to.

<br>

<img src="assignment screenshots/ss10.png" alt="Alt text" width="800">

This screenshot shows that the pull request was successful and the branches were merged.

<br>

<img src="assignment screenshots/ss11.png" alt="Alt text" width="800">

<br>

This final screenshot shows the final look of my repository with the newly merged file dummy-doc.py included.

<br>

**Requirements.txt**

Requirements.txt is a file used in Python projects to specify the external libraries, pacakages and their versions required for the project to run. This helps ensure the project can be setup and run successfully across different machines.

<br>

**.gitignore**

A .gitignore file is a text file used in Git repositories to specify which files or directories should be ignored by version control. It helps prevent unnecessary files from being tracked or committed.

