// Code generated by protoc-gen-validate. DO NOT EDIT.
// source: errors/errors.proto

package furmanov_errors_v1_proto

import (
	"bytes"
	"errors"
	"fmt"
	"net"
	"net/mail"
	"net/url"
	"regexp"
	"sort"
	"strings"
	"time"
	"unicode/utf8"

	"google.golang.org/protobuf/types/known/anypb"
)

// ensure the imports are used
var (
	_ = bytes.MinRead
	_ = errors.New("")
	_ = fmt.Print
	_ = utf8.UTFMax
	_ = (*regexp.Regexp)(nil)
	_ = (*strings.Reader)(nil)
	_ = net.IPv4len
	_ = time.Duration(0)
	_ = (*url.URL)(nil)
	_ = (*mail.Address)(nil)
	_ = anypb.Any{}
	_ = sort.Sort
)

// Validate checks the field values on ErrorDetail with the rules defined in
// the proto definition for this message. If any rules are violated, the first
// error encountered is returned, or nil if there are no violations.
func (m *ErrorDetail) Validate() error {
	return m.validate(false)
}

// ValidateAll checks the field values on ErrorDetail with the rules defined in
// the proto definition for this message. If any rules are violated, the
// result is a list of violation errors wrapped in ErrorDetailMultiError, or
// nil if none found.
func (m *ErrorDetail) ValidateAll() error {
	return m.validate(true)
}

func (m *ErrorDetail) validate(all bool) error {
	if m == nil {
		return nil
	}

	var errors []error

	// no validation rules for Service

	// no validation rules for Code

	// no validation rules for Message

	// no validation rules for Fields

	if len(errors) > 0 {
		return ErrorDetailMultiError(errors)
	}

	return nil
}

// ErrorDetailMultiError is an error wrapping multiple validation errors
// returned by ErrorDetail.ValidateAll() if the designated constraints aren't met.
type ErrorDetailMultiError []error

// Error returns a concatenation of all the error messages it wraps.
func (m ErrorDetailMultiError) Error() string {
	msgs := make([]string, 0, len(m))
	for _, err := range m {
		msgs = append(msgs, err.Error())
	}
	return strings.Join(msgs, "; ")
}

// AllErrors returns a list of validation violation errors.
func (m ErrorDetailMultiError) AllErrors() []error { return m }

// ErrorDetailValidationError is the validation error returned by
// ErrorDetail.Validate if the designated constraints aren't met.
type ErrorDetailValidationError struct {
	field  string
	reason string
	cause  error
	key    bool
}

// Field function returns field value.
func (e ErrorDetailValidationError) Field() string { return e.field }

// Reason function returns reason value.
func (e ErrorDetailValidationError) Reason() string { return e.reason }

// Cause function returns cause value.
func (e ErrorDetailValidationError) Cause() error { return e.cause }

// Key function returns key value.
func (e ErrorDetailValidationError) Key() bool { return e.key }

// ErrorName returns error name.
func (e ErrorDetailValidationError) ErrorName() string { return "ErrorDetailValidationError" }

// Error satisfies the builtin error interface
func (e ErrorDetailValidationError) Error() string {
	cause := ""
	if e.cause != nil {
		cause = fmt.Sprintf(" | caused by: %v", e.cause)
	}

	key := ""
	if e.key {
		key = "key for "
	}

	return fmt.Sprintf(
		"invalid %sErrorDetail.%s: %s%s",
		key,
		e.field,
		e.reason,
		cause)
}

var _ error = ErrorDetailValidationError{}

var _ interface {
	Field() string
	Reason() string
	Key() bool
	Cause() error
	ErrorName() string
} = ErrorDetailValidationError{}
