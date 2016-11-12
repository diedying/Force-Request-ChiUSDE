module Session_Helper
    
    def session_update( key, value)
        byebug
        session[key] = value
    end
    
    def session_get(key)
       session[key]
    end
    
    def session_removeDel(val)
        @val = 25
        byebug
        @val2 = 50
        session = {}
        byebug
    end
end