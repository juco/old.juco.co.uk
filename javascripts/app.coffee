class Container
  @containers:
    skillsContainer: new Container '.skills-container'
    contactContainer: new Container '.contact-container'

  @byName: (name) ->
    throw Error 'Container is not registered' unless @containers[name]
    @containers[name]

  @eachContainer: (cb) ->
    for name, container of @containers
      cb.call(this, name, container)

  constructor: (selector) ->
    @container = document.querySelector selector

  show: ->
    @container.classList = @container.classList || []
    @container.classList.remove 'hidden'
    @container.classList.add 'visible'

  hide: ->
    @container.classList.add 'hidden'
    @container.classList.remove 'visible'

  children: ->
    @container.getElementsByTagName '*'

  eachChild: (cb) ->
    Array.prototype.forEach.call this.children(), (item) ->
      cb.call(this, item)

# Skills events
document.querySelector('#skills').addEventListener 'click', ->
  Container.containers.skillsContainer.show()
document.querySelector('#close-skills').addEventListener 'click', ->
  skillsContainer.hide()

# Contact events
document.querySelector('#contact').addEventListener 'click', ->
  Container.byName('contactContainer').show()

document.body.addEventListener('click', (e) ->
  ignored = []
  Container.eachContainer (name, container) ->
    container.eachChild (el) ->
      ignored.push el

  isIgnored = Array.prototype.some.call ignored, (item) ->
    item == e.target

  Container.eachContainer (name, container) ->
    container.hide()
, true)
