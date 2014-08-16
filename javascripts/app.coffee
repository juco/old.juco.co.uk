# Toggle the skills modal
toggleSkills = (show) ->
  skillsContainer = document.querySelector('.skills-container')
  if show
    skillsContainer.classList.remove 'hidden'
  else
    skillsContainer.classList.add 'hidden'

document.querySelector('#skills').addEventListener 'click', ->
  toggleSkills true

document.querySelector('#close-skills').addEventListener 'click', ->
  toggleSkills false
