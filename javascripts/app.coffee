class Container
  # Load the containers
  @load: ->
    @containers || @containers =
      skillsContainer: new Container 'skills', '.skills-container'
      contactContainer: new Container 'contact', '.contact-container'

  # Grab a container by name
  @byName: (name) ->
    throw Error 'Container is not registered' unless @containers[name]
    @containers[name]

  # Iterate through the containers and execute the given callback on each
  @eachContainer: (cb) ->
    for name, container of @containers
      cb.call(this, name, container)

  constructor: (name, selector) ->
    @name = name
    @container = document.querySelector selector
    this.bindEvents()

  # Bind any container events
  bindEvents: ->
    @container
      .querySelector('.actions .cancel-link')
      .addEventListener 'click', =>
        this.hide()
    document
      .querySelector(".show-#{@name}")
      .addEventListener 'click', =>
        this.show()

  show: ->
    @container.classList = @container.classList || []
    @container.classList.remove 'hidden'
    @container.classList.add 'visible'

  hide: ->
    @container.classList.add 'hidden'
    @container.classList.remove 'visible'

  # Get all children elements for the container
  children: ->
    children = @container.getElementsByTagName '*'
    Array.prototype.push.call this, children, this.container
    children

  # Execute the given callback for each container child
  eachChild: (cb) ->
    Array.prototype.forEach.call this.children(), (item) ->
      cb.call(this, item)

# Load the containers
Container.load()

# Detect a click anywhere on the DOM. Hide an active modal if not inside
document.body.addEventListener('click', (e) ->
  ignored = []
  Container.eachContainer (name, container) ->
    container.eachChild (el) ->
      ignored.push el

  isIgnored = ignored.some (item) ->
    item == e.target

  unless isIgnored
    Container.eachContainer (name, container) ->
      container.hide()
, true)
