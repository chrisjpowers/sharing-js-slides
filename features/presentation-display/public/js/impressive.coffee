$ ->
  slides = []
  window.isAdmin = false
  inSync = true

  imp = window.imp = new Impress()
  currentId = imp.getId()
  $("#impress").show()
  syncToggle = $("#sync-toggle")

  syncToggle.delegate ".return-to-sync", "click", (e) ->
    e.preventDefault()
    returnSync()

  document.addEventListener "keydown", (event) ->
    switch event.keyCode
      when 33, 37, 38 # pg up, left, up
        event.preventDefault()
        gotoPrev()
      when 9, 32, 34, 39, 40 # space, pg down, right, down
        event.preventDefault()
        gotoNext()

  gotoSlide = (id) ->
    currentId = id
    imp.goto id if inSync

  gotoPrev = ->
    if isAdmin
      now.updateSlide isAdmin, imp.getPrevId()
    else
      leaveSync()
      imp.gotoPrev()
  
  gotoNext = ->
    if isAdmin
      now.updateSlide isAdmin, imp.getNextId()
    else
      leaveSync()
      imp.gotoNext()

  leaveSync = ->
    inSync = false
    syncToggle.addClass "out-of-sync"
    syncToggle.html "Out of Sync (<a href='#' class='return-to-sync'>Sync Up</a>)"

  returnSync = ->
    inSync = true
    syncToggle.removeClass "out-of-sync"
    syncToggle.html "In Sync"
    imp.goto currentId

  now.ready ->
    now.goto = (id) ->
      gotoSlide(id)

    now.getCurrentId (id) -> gotoSlide(id)
