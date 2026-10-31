#Requires AutoHotkey v2.1-alpha.36

/**
 * Base class for typedefs.
 * 
 * When a subclass is used as a parameter type, it can accept either an instance
 * of the subclass or a value of the underlying type.  Return values are instances.
 */
struct Typedef {
    static __new() {
        if !IsSet(vtype := (this.GetOwnPropDesc)(this.Prototype, 'value')?.type)
            return
        DefineProp this.Prototype, '__value', {
            set: (this, value) {
                this.value := HasBase(value, this.base) ? value.value : value
            }
        }
    }
    __new(v?) {
        IsSet(v) && this.__value := v
    }
}