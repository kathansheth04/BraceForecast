
#type 'make git-"message for commit" in terminal
#just an option
git-%:
	git add .
	git commit -m "$(@:git-%=%)"
	git push origin master