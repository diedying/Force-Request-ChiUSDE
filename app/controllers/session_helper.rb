module Session_Helper
    
    def session_update( key, value)
        session[key] = value
    end
    
    def session_get(key)
       session[key]
    end
    
    def session_removeDel(val)
        @val = 25
        @val2 = 50
        session = {}
    end
end