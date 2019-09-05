moveForward(1)
say("hello", 1)
wait(time)
test_args(1, *a, **k)

@register("api")
@http_post
def callback(p, q=2, *a, **k):
    """
    a call function
    """
    print(p, q)

registerClickEvent(callback)
