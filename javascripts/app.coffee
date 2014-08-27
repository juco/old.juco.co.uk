# Skills container
class Skills
  @skillsContainer = document.querySelector('.skills-container')
  @show: ->
    @skillsContainer.classList.remove 'hidden'
    @skillsContainer.classList.add 'visible'
  @hide: ->
    @skillsContainer.classList.add 'hidden'
    @skillsContainer.classList.remove 'visible'

document.querySelector('#skills').addEventListener 'click', ->
  Skills.show()
document.querySelector('#close-skills').addEventListener 'click', ->
  Skills.hide()

document.body.addEventListener('click', (e) ->
  ignored = document.querySelector('.skills-container').getElementsByTagName('*')
  isIgnored = Array.prototype.some.call ignored, (item) ->
    item == e.target
  Skills.hide() unless isIgnored
, true)
